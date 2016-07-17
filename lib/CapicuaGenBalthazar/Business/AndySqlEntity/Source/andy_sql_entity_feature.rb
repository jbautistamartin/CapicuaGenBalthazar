
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


require 'active_support/core_ext/object/blank'

require_relative '../../../balthazar'
require 'CapicuaGenMelchior/Mixins/entity_sql_table_mixin'
require_relative '../../../Mixins/java_mixin'


module CapicuaGen::Balthazar

  # Característica generadora para crear entidades de negocio
  # a traves de entidades extraidas un archivo .sql
  class AndySqlEntityFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar
    include CapicuaGen::Melchior

    attr_accessor :class_accessor

    public

    # Inicializa la característica
    def initialize(values= {})
      super(values)

      self.types= [:business_entities] if self.types.blank?

      # Configuro los templates
      set_template("table_entity", Template.new(:file => 'table_entity.erb'))

    end


    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets

      # Busco  las características que contiene entidades de SQL para una table
      get_tables do |e|
        set_template_target("table_entity/#{get_entity_name(e.name)}",
                            TemplateTarget.new(
                                :out_file       => get_package_out_file("#{get_entity_name(e.name)}.java"),
                                :types          => :proyect_file,
                                :class_name     => get_entity_name(e.name),
                                :entity_schema  => e,
                                :class_accessor => @class_accessor,
                            )
        )

      end

    end

    # Resetea los atributos personalizados de la característica (antes de establecer el generador)
    def reset_attributes
      self.generation_attributes[:package]        = nil
      self.generation_attributes[:package_out_dir]= nil
    end

    # Configura los atributos personalizados de la característica (antes de establecer el generador)
    def configure_attributes()
      self.generation_attributes[:package]        = "#{self.generation_attributes[:package]}.beans" unless self.generation_attributes.has_in_self?(:package)
      self.generation_attributes[:package_out_dir]= get_package_out_dir
    end


    # Obtiene el nombre de la entidad (como clase de Java)
    def get_entity_name(entity_name)
      return entity_name
    end

    # Obtiene el nombre completo de la entidad (como clase de Java)
    def get_entity_full_name(entity_name)
      return "#{self.generation_attributes[:package]}.#{get_entity_name(entity_name)}"
    end

  end
end


