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

module CapicuaGen::Melchior

  # Extiende la clase Entity field Schema que representa una entidad
  # de negocio con funcionalidad para convertirse sus propiedades
  # a tipos simples de Java.
  class EntityFieldSchema

    def java_type

      case @type.upcase
        when "SMALLINT"
          return "Int16"
        when "INTEGER", "INT"
          return "int"
        when "DECIMAL", "REAL", "MONEY"
          return "decimal"
        when "CHAR", "VARCHAR", "NCHAR", "NVARCHAR"
          return "String"
        when "DATE", "DATETIME"
          return "DateTime"
        when "BIT"
          return "bool"
        else
          return "object"
      end
    end


  end

end
