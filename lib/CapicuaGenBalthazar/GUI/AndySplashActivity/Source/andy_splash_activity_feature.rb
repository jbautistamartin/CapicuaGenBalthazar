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
require_relative '../../../Mixins/android_context_provider_mixin'
require_relative '../../../Mixins/java_mixin'


module CapicuaGen::Balthazar

  # Caracteristica generadora pantalla de bienvenida
  class AndySplashActivityFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar

    public

    # Inicializa la caracteristica
    def initialize(values= {})
      super(values)

      # Configuro los tipos si estos no han sido configurados previamente
      self.types= [:catalog] if self.types.blank?


      # Configuro los templates
      set_template("splash", Template.new(:file => 'splash.erb'))
      set_template('splash_activity', Template.new(:file => 'splash_activity.erb'))
      set_template('logo', Template.new(:file => 'logo.png'))

    end

    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets

      set_template_target("splash", TemplateTarget.new(:out_file => get_package_out_file("SplashActivity.java")))
      set_template_target("splash_activity", TemplateTarget.new(:out_file => get_activity_out_file("activity_splash.xml")))
      set_template_target("logo", TemplateTarget.new(:out_file => get_drawable_out_file("logo.png"), :copy_only => true))

    end

    # Resetea los atributos personalizados de la caracteristica (antes de establecer el generador)
    def reset_attributes
      self.generation_attributes[:package]        = nil
      self.generation_attributes[:package_out_dir]= nil
    end

    # Configura los atributos personalizados de la caracteristica (antes de establecer el generador)
    def configure_attributes()
      self.generation_attributes[:package]        = "#{self.generation_attributes[:package]}.activities" unless self.generation_attributes.has_in_self?(:package)
      self.generation_attributes[:package_out_dir]= get_package_out_dir
    end


    # Genera la caracteristica
    def generate
      super()
      generate_configuration
    end

    # Modifica el archivo Manifest para agregar las actividades.
    def generate_configuration

      manifest_file= get_manifest_file

      return unless manifest_file

      # Ruta para conseguir el archivo app.config

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
              android:name= ".activities.SplashActivity"
              android:screenOrientation= "portrait"
              android:theme= "@android:style/Theme.Holo.Light.NoActionBar">
        </activity>
    </application>
=end

      # Recupero el nodo
      xpath                            = "application/activity[@android:name= '.activities.SplashActivity']"
      node                             = XMLHelper.get_node_from_xml_document(xml, xpath)

      # Configuro el nodo
      node['android:name']             = ".activities.SplashActivity"
      node['android:screenOrientation']= "portrait"
      node['android:theme']            = "@android:style/Theme.Holo.Light.NoActionBar"
=begin
    <application>
       <activity
              android:name= ".activities.SplashActivity"
              android:screenOrientation= "portrait"
              android:theme= "@android:style/Theme.Holo.Light.NoActionBar">
              <intent-filter>
                  <action android:name= "android.intent.action.MAIN" />
                  <category android:name= "android.intent.category.LAUNCHER" />
              </intent-filter>
          </activity>
    </application>
=end

      # Recupero el nodo
      xpath                            = "application/activity[@android:name= '.activities.SplashActivity']/intent-filter/action[@android:name= 'android.intent.action.MAIN']"
      node                             = XMLHelper.get_node_from_xml_document(xml, xpath)

      # Configuro el nodo
      node['android:name']             = "android.intent.action.MAIN"

      # Recupero el nodo
      xpath                            = "application/activity[@android:name= '.activities.SplashActivity']/intent-filter/category[@android:name= 'android.intent.category.LAUNCHER']"
      node                             = XMLHelper.get_node_from_xml_document(xml, xpath)

      # Configuro el nodo
      node['android:name']             = "android.intent.category.LAUNCHER"

      # Formateo el texto
      formatted_xml                    = XMLHelper.format(xml.to_xml)

      # Guardo el resultado
      File.write(manifest_file, formatted_xml)

    end
  end

end