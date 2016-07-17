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


=begin
Este Mixin esta programado para obtener información de las características
de proveedoras de fragmentos de android :fragment
=end

module CapicuaGen::Balthazar

  public

  # Obtiene el nombre completo de un framento en base al nombre de una entidad
  def get_entity_fragment_full_name(entity_name)
    # Busco  las características que contiene entidades de SQL para una table
    generator.get_features_in_targets_by_type(:fragment).each do |f|
      # Obtengo las entidades
      return f.get_entity_fragment_full_name(entity_name)
    end
  end


end

