package language

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/bazelbuild/bazel-gazelle/config"
	"github.com/bazelbuild/bazel-gazelle/label"
	"github.com/bazelbuild/bazel-gazelle/language"
	"github.com/bazelbuild/bazel-gazelle/repo"
	"github.com/bazelbuild/bazel-gazelle/resolve"
	"github.com/bazelbuild/bazel-gazelle/rule"
	"gopkg.in/yaml.v3"
)

type Chisel struct{}

var _ language.Language = (*Chisel)(nil)
var _ language.ModuleAwareLanguage = (*Chisel)(nil)

func NewLanguage() *Chisel {
	return &Chisel{}
}

func (c *Chisel) RegisterFlags(_ *flag.FlagSet, _ string, _ *config.Config) {
}

func (c *Chisel) CheckFlags(_ *flag.FlagSet, _ *config.Config) error {
	return nil
}

func (c *Chisel) KnownDirectives() []string {
	return nil
}

func (c *Chisel) Configure(_ *config.Config, _ string, _ *rule.File) {
}

func (c *Chisel) Name() string {
	return "chisel"
}

func (c *Chisel) Imports(conf *config.Config, r *rule.Rule, f *rule.File) []resolve.ImportSpec {
	return nil
}

func (c *Chisel) Embeds(r *rule.Rule, from label.Label) []label.Label {
	return nil
}

func (c *Chisel) Resolve(conf *config.Config, ix *resolve.RuleIndex, rc *repo.RemoteCache, r *rule.Rule, imports interface{}, from label.Label) {
}

func (*Chisel) Kinds() map[string]rule.KindInfo {
	return map[string]rule.KindInfo{
		"chisel_slice": {},
	}
}

func (c *Chisel) GenerateRules(args language.GenerateArgs) language.GenerateResult {
	if filepath.Base(args.Dir) != "slices" {
		return language.GenerateResult{}
	}

	d := filepath.Dir(args.Dir)
	if _, err := os.Lstat(filepath.Join(d, "chisel.yaml")); os.IsNotExist(err) {
		if _, err := os.Lstat(filepath.Join(d, "chisel.yml")); os.IsNotExist(err) {
			return language.GenerateResult{}
		}
	}

	dependency := make(map[string]map[string]struct{})
	var packages []*chiselPackage
	for _, v := range args.RegularFiles {
		if !strings.HasSuffix(v, ".yaml") && !strings.HasSuffix(v, ".yml") {
			continue
		}

		f, err := os.Open(filepath.Join(args.Dir, v))
		if err != nil {
			continue
		}
		var p chiselPackage
		if err := yaml.NewDecoder(f).Decode(&p); err != nil {
			log.Printf("%s: %v", v, err)
			continue
		}
		p.Filename = v
		if len(p.Slices) > 1 {
			p.IntegrationSlices = make(map[string]struct{})
			for sliceName, s := range p.Slices {
				if len(s.Contents) == 0 && len(s.Essential) > 0 {
					p.IntegrationSlices[sliceName] = struct{}{}
				}
			}
		}
		packages = append(packages, &p)

		for _, s := range p.Slices {
			for _, e := range s.Essential {
				n := e[:strings.LastIndex(e, "_")]
				if n == p.Package {
					continue
				}
				if _, ok := dependency[n]; !ok {
					dependency[n] = make(map[string]struct{})
				}
				sliceName := e[strings.LastIndex(e, "_")+1:]
				dependency[n][sliceName] = struct{}{}
			}
		}
	}

	var res language.GenerateResult
	for _, p := range packages {
		for sliceName, s := range p.Slices {
			var deps []string
			for _, e := range s.Essential {
				n := e[:strings.LastIndex(e, "_")]
				if n == p.Package {
					continue
				}
				var l label.Label
				if len(dependency[n]) == 1 {
					l = label.New("", args.File.Pkg, n)
				} else {
					l = label.New("", args.File.Pkg, e)
				}
				deps = append(deps, l.String())
			}

			name := p.Package
			var packageName string
			var publicRule bool
			if d, ok := dependency[p.Package]; ok {
				if _, ok := d[sliceName]; !ok {
					continue
				}
				if len(d) > 1 {
					name = fmt.Sprintf("%s_%s", p.Package, sliceName)
					packageName = p.Package
				}
			} else {
				publicRule = true
				if len(p.Slices) > 1 && len(p.IntegrationSlices) == 0 {
					name = fmt.Sprintf("%s_%s", p.Package, sliceName)
					packageName = p.Package
				}
			}
			if len(p.IntegrationSlices) > 0 {
				if _, ok := p.IntegrationSlices[sliceName]; !ok {
					continue
				}
			}
			r := rule.NewRule("chisel_slice", name)
			r.SetAttr("src", p.Filename)
			r.SetAttr("slice", sliceName)
			if len(deps) > 0 {
				r.SetAttr("deps", deps)
			}
			if packageName != "" {
				r.SetAttr("package_name", packageName)
			}
			if publicRule {
				r.SetAttr("visibility", []string{"//visibility:public"})
			}
			res.Gen = append(res.Gen, r)
			res.Imports = append(res.Imports, nil)
		}
	}
	return res
}

func (*Chisel) Loads() []rule.LoadInfo {
	panic("Unreachable")
}

func (*Chisel) ApparentLoads(_ func(string) string) []rule.LoadInfo {
	return []rule.LoadInfo{
		{
			Name:    "//private/chisel:defs.bzl",
			Symbols: []string{"chisel_slice"},
		},
	}
}

func (c *Chisel) Fix(conf *config.Config, f *rule.File) {
}

type chiselPackage struct {
	Package string `yaml:"package"`
	Slices  map[string]*chiselSlice

	Filename          string              `yaml:"-"`
	IntegrationSlices map[string]struct{} `yaml:"-"`
}

type chiselSlice struct {
	Essential []string            `yaml:"essential"`
	Contents  map[string]struct{} `yaml:"contents"`
}
