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

=begin
Este Mixin esta programado para obtener información de las caracteristicas
de proveedoras de contexto de android :r_provider
=end

module CapicuaGen::Balthazar

  public


  # Obtiene la ruta completa de la clase R de Android.
  def get_r_full_name
    # Busco  las caracteristicas que contiene entidades de SQL para una table
    generator.get_features_in_targets_by_type(:r_provider).each do |f|
      # Obtengo las entidades
      return f.get_r_full_name
    end

    return nil
  end

  # Obtiene la ruta completa de un layout
  def get_activity_out_file(file)

    path    = File.join("res", "layout")
    out_path= File.join(path, file)
    return out_path

  end

  # Obtiene la ruta completa de un archivo drawable
  def get_drawable_out_file(file)

    path    = File.join("res", "drawable")
    out_path= File.join(path, file)
    return out_path

  end

  # Obtiene la ruta completa de un mipmap
  def get_mipmap_out_file(resolution, file)

    path    = File.join("res", "mipmap-#{resolution}")
    out_path= File.join(path, file)
    return out_path

  end

  # Obtiene la ruta completa de un manifiesto
  def get_manifest_file

    return File.join(self.generation_attributes[:out_dir], 'AndroidManifest.xml')

  end

  # Obtiene el paquete base del proyecto
  def get_base_package
    return "#{@generator.generation_attributes[:package]}";
  end

end

