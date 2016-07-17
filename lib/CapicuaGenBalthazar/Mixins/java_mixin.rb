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
propias del lenguaje Java.
=end

module CapicuaGen::Balthazar

  public

  # Obtiene el directorio actual de salida en base al paquete
  # de la característica actual
  def get_package_out_dir
    package= self.generation_attributes[:package]
    out_dir= self.generation_attributes[:out_dir]

    path    = File.join(out_dir, "java", package.gsub(".", "/"))
    out_path= File.join("java", package.gsub(".", "/"))
    FileUtils::mkdir_p path

    return out_path

  end

  # Obtiene el path actual de archivo en base al paquete
  # de la característica actual
  def get_package_out_file(file)

    package = self.generation_attributes[:package]
    out_path= File.join("java", package.gsub(".", "/"), file)
    return out_path

  end


end

