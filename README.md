# discourse-lock-unlock-tl

This plugin provides two Discourse Automation scripts to manage user trust levels when they are added to or removed from a specific group.

## Installation

Follow the standard Discourse plugin installation guide.

## Usage

### 1. Lock Trust Level on Group Add

This script locks a user's trust level when they are added to a specified group.

- **Trigger**: `User added to group`
- **Script**: `Lock user trust level on group add`
- **Fields**:
  - `target_group`: The group to monitor.
  - `trust_level`: The trust level to assign and lock.

### 2. Unlock Trust Level on Group Remove

This script unlocks a user's trust level when they are removed from the specified group.

- **Trigger**: `User removed from group`
- **Script**: `Unlock user trust level`
- **Fields**:
  - `target_group`: The group to monitor.

## License

MIT
