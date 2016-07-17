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

require 'nokogiri'
require 'active_support/core_ext/object/blank'

require_relative '../../../balthazar'

module CapicuaGen::Balthazar

  # Característica generadora para obtener información acerca del contexto
  # del proyecto de android
  class AndyContextProvider < CapicuaGen::Feature
    include CapicuaGen
    include CapicuaGen::Balthazar


    public

    # Inicializa la característica
    def initialize(values= {})
      super(values)

      # Configuro los tipos si estos no han sido configurados previamente
      self.types= [:r_provider] if self.types.blank?

    end

    # Devuelve referencia a R
    def get_r_full_name
      return "#{@generation_attributes[:package]}.R";
    end


  end
end



