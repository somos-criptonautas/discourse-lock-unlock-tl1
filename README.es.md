# discourse-lock-unlock-tl

[ENGLISH](README.md) | **ESPAÑOL**

Mantenido por Criptonautas. Sin afiliación ni respaldo de Discourse (Civilized Discourse Construction Kit, Inc.).

[EXPERIMENTAL] Este plugin añade dos scripts de Discourse Automation para gestionar el nivel de confianza de los usuarios cuando se los añade o se los quita de un grupo concreto.

## Instalación

Sigue la guía estándar de instalación de plugins de Discourse.

## Uso

### 1. Bloquear el nivel de confianza al añadir al grupo

Este script bloquea el nivel de confianza de un usuario cuando se lo añade a un grupo especificado.

- **Disparador**: `User added to group`
- **Script**: `Lock user trust level on group add`
- **Campos**:
  - `target_group`: el grupo a vigilar.
  - `trust_level`: el nivel de confianza a asignar y bloquear.

### 2. Desbloquear el nivel de confianza al quitar del grupo

Este script desbloquea el nivel de confianza de un usuario cuando se lo quita del grupo especificado.

- **Disparador**: `User removed from group`
- **Script**: `Unlock user trust level`
- **Campos**:
  - `target_group`: el grupo a vigilar.

## Licencia

MIT. Consulta [LICENSE](LICENSE).

Texto de este README bajo [CC BY-NC-SA 4.0](CC-BY-NC-SA-4.0.txt).
