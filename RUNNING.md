

<!-- local-development:start -->
# Desarrollo local

Puedes abrir este repositorio en VS Code, Antigravity o Sublime Text. El compilador y los servicios necesarios dependen del componente indicado abajo.

## Ruby / Rails

Usa la versión de Ruby y el Gemfile de cada aplicación en WSL o Linux. Crea una base de datos local y ejecuta sus pruebas antes de iniciarla. El editor de Windows no aporta el runtime Ruby.

## Componentes y validación

Inventario y compilaciones locales del 2026-11-15. Una compilación correcta no acredita todavía interacción, compatibilidad de base de datos, instalador ni despliegue.

| Componente | Tipo / destino | Validación |
| --- | --- | --- |
| [RoR-API-master-MerianHerrera/Rails-API/Gemfile](<RoR-API-master-MerianHerrera/Rails-API/Gemfile>) | ruby | Sin ejecutar |
| [RoR-API-master-MerianHerrera/RoR-API/Gemfile](<RoR-API-master-MerianHerrera/RoR-API/Gemfile>) | ruby | Sin ejecutar |
| [raullunab12-api-ror-3a7eff9cee0c/api_raul/Gemfile](<raullunab12-api-ror-3a7eff9cee0c/api_raul/Gemfile>) | ruby | Sin ejecutar |

## Archivos ignorados

`.gitignore` excluye credenciales locales, estado del editor y salidas de las herramientas detectadas. No deja de versionar archivos que ya estaban en Git. Los manifiestos, archivos de bloqueo, recursos fuente y scripts de esquema forman parte del código.
<!-- local-development:end -->

<!-- improvements-20261119:start -->
## Mejoras y verificación — 2026-11-19 (Corrección de NoMethodError en update, códigos HTTP 404/422 y validación de login Rails)

- Corregido `ProductController#update` (llamaba `.update` antes de comprobar `nil`) y añadidos códigos HTTP reales `:ok`, `:created`, `:not_found`, `:unprocessable_entity`.
- Corregidos los estados HTTP en `TransactionController#create` (errores de validación devolvían `200`, ahora `422` y éxito `201`) y validación de credenciales vacías en `UserController#signin`/`signout`.
- Validación: `ruby -c` (WSL Ruby 3.2.3) y 9 aserciones unitarias sobre los 3 controladores.
<!-- improvements-20261119:end -->
