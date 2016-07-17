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
require_relative '../../..//Mixins/card_view_fragment_mixin'
require 'CapicuaGenMelchior/Mixins/entity_sql_table_mixin'
require_relative '../../../Mixins/android_context_provider_mixin'
require_relative '../../../Mixins/java_mixin'


module CapicuaGen::Balthazar

  # Característica generadora para pantalla visualizadora de entidades
  class AndyMainActivityFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar
    include CapicuaGen::Melchior

    public

    # Inicializa la característica
    def initialize(values= {})
      super(values)

      # Configuro los tipos si estos no han sido configurados previamente
      self.types= [:catalog] if self.types.blank?

      # Configuro los templates
      set_template("main", Template.new(:file => 'main.erb'))
      set_template('main_activity', Template.new(:file => 'main_activity.erb'))

    end

    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets
      set_template_target("main", TemplateTarget.new(:out_file => get_package_out_file("MainActivity.java")))
      set_template_target("main_activity", TemplateTarget.new(:out_file => get_activity_out_file("activity_main.xml")))
    end

    # Resetea los atributos personalizados de la característica (antes de establecer el generador)
    def reset_attributes
      self.generation_attributes[:package]        = nil
      self.generation_attributes[:package_out_dir]= nil
    end

    # Configura los atributos personalizados de la característica (antes de establecer el generador)
    def configure_attributes()
      self.generation_attributes[:package]        = "#{self.generation_attributes[:package]}.activities" unless self.generation_attributes.has_in_self?(:package)
      self.generation_attributes[:package_out_dir]= get_package_out_dir
    end

    # Genera el código de la carateristica
    def generate
      super()
      begin
        message_helper.add_indent
        generate_configuration
      ensure
        message_helper.remove_indent
      end

    end


    # Modifica el archivo Manifest para agregar las actividades.
    def generate_configuration

      manifest_file= get_manifest_file

      return unless manifest_file

      if not File.exist? manifest_file
        message_helper.puts_file_modified manifest_file, :ignore
        return
      end

      # Ruta para conseguir el archivo manifiest.xml

      xml= Nokogiri::XML(File.read(manifest_file))
=begin
      <uses-permission android:name= "android.permission.INTERNET" />
=end
      xpath                            = "uses-permission[@android:name= 'android.permission.INTERNET']"
      node                             = XMLHelper.get_node_from_xml_document(xml, xpath)

      # Configuro el nodo
      node['android:name']             = "android.permission.INTERNET"
=begin
    <application>
         <activity
            android:name= ".activities.MainActivity"
            android:screenOrientation= "portrait"
            android:theme= "@style/Theme.AppCompat" />
    </application>
=end

      # Recupero el nodo
      xpath                            = "application/activity[@android:name= '.activities.MainActivity']"
      node                             = XMLHelper.get_node_from_xml_document(xml, xpath)

      # Configuro el nodo
      node['android:name']             = ".activities.MainActivity"
      node['android:screenOrientation']= "portrait"
      node['android:theme']            = "@style/Theme.AppCompat"


      # Formateo el texto
      formatted_xml                    = XMLHelper.format(xml.to_xml)

      # Guardo el resultado
      File.write(manifest_file, formatted_xml)

      message_helper.puts_file_modified manifest_file, :override

    end

  end

end