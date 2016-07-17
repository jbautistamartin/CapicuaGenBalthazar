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
require_relative '../../../Mixins/java_mixin'
require_relative '../../../Mixins/android_context_provider_mixin'


module CapicuaGen::Balthazar

  # Característica generadora para crear los iconos de una aplicación Android
  class AndyIcLauncherFeature < CapicuaGen::TemplateFeature
    include CapicuaGen
    include CapicuaGen::Balthazar

    public

    # Inicializa la característica
    def initialize(values= {})
      super(values)

      # Configuro los tipos si estos no han sido configurados previamente
      self.types= [:catalog] if self.types.blank?

      set_template('ic_launcher_mipmap-xhdpi', Template.new(:file => 'ic_launcher_mipmap-xhdpi.png'))
      set_template('ic_launcher_mipmap-xxhdpi', Template.new(:file => 'ic_launcher_mipmap-xxhdpi.png'))
      set_template('ic_launcher_mipmap-xxxhdpi', Template.new(:file => 'ic_launcher_mipmap-xxxhdpi.png'))
      set_template('ic_launcher_mipmap-hdpi', Template.new(:file => 'ic_launcher_mipmap-hdpi.png'))
      set_template('ic_launcher_mipmap-mdpi', Template.new(:file => 'ic_launcher_mipmap-mdpi.png'))


    end

    # Configura los objetivos de las platillas (despues de establecer el generador)
    def configure_template_targets

      set_template_target('ic_launcher_mipmap-mdpi', TemplateTarget.new(:out_file => get_mipmap_out_file('mdpi', 'ic_launcher.png'), :copy_only => true))
      set_template_target('ic_launcher_mipmap-hdpi', TemplateTarget.new(:out_file => get_mipmap_out_file('hdpi', 'ic_launcher.png'), :copy_only => true))
      set_template_target('ic_launcher_mipmap-xhdpi', TemplateTarget.new(:out_file => get_mipmap_out_file('xhdpi', 'ic_launcher.png'), :copy_only => true))
      set_template_target('ic_launcher_mipmap-xxhdpi', TemplateTarget.new(:out_file => get_mipmap_out_file('xxhdpi', 'ic_launcher.png'), :copy_only => true))
      set_template_target('ic_launcher_mipmap-xxxhdpi', TemplateTarget.new(:out_file => get_mipmap_out_file('xxxhdpi', 'ic_launcher.png'), :copy_only => true))

    end


  end

end