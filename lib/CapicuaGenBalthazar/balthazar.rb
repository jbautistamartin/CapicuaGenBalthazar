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
Balthazar es un conjunto de generadores de características de ejemplo pertenecientes a CapicuaGen
que generan un proyecto de Android
=end

require_relative 'version'
require 'CapicuaGen/capicua_gen'
require_relative 'AndroidLanguage/AndyContextProvider/Source/andy_context_provider_feature'
require_relative 'Business/AndySqlEntity/Source/andy_sql_entity_feature'
require_relative 'Entities/AndyEntity/Source/entity_field_schema.rb'
require_relative 'GUI/AndyEntityCardViewFragment/Source/andy_entity_card_view_fragment_feature'
require_relative 'GUI/AndyIcLauncher/Source/andy_ic_launcher_feature'
require_relative 'GUI/AndyMainActivity/Source/andy_main_activity_feature'
require_relative 'GUI/AndySplashActivity/Source/andy_splash_activity_feature'
require_relative 'Web/AndyWebRequest/Source/andy_web_request_feature'