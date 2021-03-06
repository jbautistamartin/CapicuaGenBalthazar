# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CapicuaGenBalthazar/version'

Gem::Specification.new do |spec|
  spec.name    = "CapicuaGenBalthazar"
  spec.version = CapicuaGenBalthazar::VERSION
  spec.authors = ["José Luis Bautista Martín"]
  spec.email   = ["joseluisbautista@gmail.com"]
  spec.date    = Date.today.to_s


  spec.summary     = %q{CapicuaGen es un software que ayuda a la creación automática de
sistemas empresariales a través de la definición y ensamblado de
diversos generadores de características. Balthazar es un conjunto de generadores de características de ejemplo pertenecientes a CapicuaGen
que generan un proyecto de Android.
}
  spec.description = %q{CapicuaGen es un software que ayuda a la creación automática de
sistemas empresariales a través de la definición y ensamblado de
diversos generadores de características.

Balthazar es un conjunto de generadores de características de ejemplo pertenecientes a CapicuaGen
que generan un proyecto de Android

El proyecto fue iniciado por José Luis Bautista Martín, el 6 de enero
de 2016.

Puede modificar y distribuir este software, según le plazca, y usarlo
para cualquier fin ya sea comercial, personal, educativo, o de cualquier
índole, siempre y cuando incluya este mensaje, y se permita acceso al
código fuente.

Este software es código libre, y se licencia bajo LGPL.

Para más información consultar http://www.gnu.org/licenses/lgpl.html
}

  spec.homepage = "http://desdelashorasextras.blogspot.mx/"
  spec.licenses = ['LGPL']

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|\.idea)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'CapicuaGen', '>=0.1.1', '~> 0.1'
  spec.add_runtime_dependency 'CapicuaGenMelchior', '>=0.1.1', '~> 0.1'

  spec.required_ruby_version = '>= 2.0.0'
end