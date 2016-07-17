=begin

CapicuaGen

CapicuaGen es un software que ayuda a la creación automática de
sistemas empresariales a través de la definición y ensamblado de
diversos generadores de características.

El proyecto fue iniciado por José Luis Bautista Martín, el 6 de enero
de 2016.

Puede modificar y distribuir este software, según le plazca, y usarlo
para cualquier fin ya sea comercial, personal, educativo, o de cualquier
índole, siempre y cuando incluya este mensaje, y se permita acceso al
código fuente.

Este software es código libre, y se licencia bajo LGPL.

Para más información consultar http://www.gnu.org/licenses/lgpl.html
=end

require_relative  '../../../balthazar'
require 'active_support/core_ext/object/blank'
require 'CapicuaGenMelchior/Mixins/entity_sql_table_mixin'
require_relative '../../../Mixins/java_mixin'


module CapicuaGen::Balthazar

  # Característica generadora para el uso de servicios json
  class AndyWebRequestFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar


    public

    # Inicializa la característica
    def initialize(values= {})
      super(values)

      self.types= [:business_entities] if self.types.blank?

      # Configuro los templates
      set_template("json_web_request", Template.new(:file => 'web_request.erb'))
    end

    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets
      set_template_target("json_web_request", TemplateTarget.new(:out_file => get_package_out_file("WebRequest.java"), :types => :proyect_file))
    end

    # Resetea los atributos personalizados de la característica (antes de establecer el generador)
    def reset_attributes
      self.generation_attributes[:package]        = nil
      self.generation_attributes[:package_out_dir]= nil
    end

    # Configura los atributos personalizados de la característica (antes de establecer el generador)
    def configure_attributes()
      self.generation_attributes[:package]        = "#{self.generation_attributes[:package]}.tools" unless self.generation_attributes.has_in_self?(:package)
      self.generation_attributes[:package_out_dir]= get_package_out_dir
    end

  end
end

