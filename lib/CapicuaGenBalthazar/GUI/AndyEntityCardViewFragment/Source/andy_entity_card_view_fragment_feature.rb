=begin

CapicuaGen

CapicuaGen es un software que ayuda a la creación automática de
sistemas empresariales a través de la definición y ensamblado de
diversos generadores de características.

El proyecto fue iniciado por José Luis Bautista Martin, el 6 de enero
del 2016.

Puede modificar y distribuir este software, según le plazca, y usarlo
para cualquier fin ya sea comercial, personal, educativo, o de cualquier
índole, siempre y cuando incluya este mensaje, y se permita acceso el
código fuente.

Este software es código libre, y se licencia bajo LGPL.

Para más información consultar http://www.gnu.org/licenses/lgpl.html
=end

require 'active_support/core_ext/object/blank'

require_relative '../../../balthazar'
require 'CapicuaGenMelchior/Mixins/entity_sql_table_mixin'
require_relative '../../../Mixins/java_mixin'
require_relative '../../../Mixins/android_context_provider_mixin'


module CapicuaGen::Balthazar

  # Caracteristica generadora para crear las vistas, fragmentos y clases necesarias
  # para mostrar entidades en las pantalla de un disposito Android
  class AndyEntityCardViewFragmentFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar
    include CapicuaGen::Melchior

    public

    # Inicializa la caracteristica
    def initialize(values= {})
      super(values)

      # Configuro los tipos si estos no han sido configurados previamente    
      self.types= [:fragment] if self.types.blank?

      # Configuro los templates
      set_template("catalog_cardview", Template.new(:file => 'catalog_cardview.erb'))
      set_template('catalog_fragment', Template.new(:file => 'catalog_fragment.erb'))
      set_template('catalog_recyclerview', Template.new(:file => 'catalog_recyclerview.erb'))

    end

    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets

      # Busco  las caracteristicas que contiene entidades de SQL para una table
      get_tables do |e|

        set_template_target("catalog_fragment/#{e.name}Fragment",
                            TemplateTarget.new(
                                :out_file      => get_package_out_file("#{e.name}Fragment.java"),
                                :types         => :proyect_file,
                                :entity_schema => e
                            )
        )


        set_template_target("catalog_cardview/cardview_#{e.name}",
                            TemplateTarget.new(
                                :out_file      => "#{get_activity_out_file("cardview_#{e.name}".downcase)}.xml",
                                :types         => :proyect_file,
                                :entity_schema => e
                            )
        )


        set_template_target("catalog_recyclerview/catalog_recyclerview_#{e.name}",
                            TemplateTarget.new(
                                :out_file      => "#{get_activity_out_file("recyclerview_#{e.name}".downcase)}.xml",
                                :types         => :proyect_file,
                                :entity_schema => e
                            )

        )


      end

    end

    # Resetea los atributos personalizados de la caracteristica (antes de establecer el generador)
    def reset_attributes
      self.generation_attributes[:package]        = nil
      self.generation_attributes[:package_out_dir]= nil
    end

    # Configura los atributos personalizados de la caracteristica (antes de establecer el generador)
    def configure_attributes()
      self.generation_attributes[:package]        = "#{self.generation_attributes[:package]}.fragments" unless self.generation_attributes.has_in_self?(:package)
      self.generation_attributes[:package_out_dir]= get_package_out_dir
    end


    # Obtiene del la clase fragment, en base al nombre de una entidad
    def get_entity_fragment_full_name(entity_name)
      return "#{self.generation_attributes[:package]}.#{entity_name}Fragment"
    end


  end

end