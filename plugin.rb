# plugin.rb
# name: discourse-lock-unlock-tl
# about: Locks new group members to a selectable Trust Level via Automation, with error logging
# version: 0.3
# authors: satonotdead

after_initialize do
  # Proceed only if the Automation plugin is loaded
  if defined?(DiscourseAutomation)

    DiscourseAutomation::Scriptable.add("lock_group_trust_level") do
      version 1

      # Admin fields
      field :target_group, component: :group, required: true
      field :trust_level, component: :trust_level, required: true

      # Run this script when a user is added to any group
      triggerables %i[user_added_to_group]

      script do |context, fields, automation|
        user = context["user"]
        group_id = fields.dig("target_group", "value").to_i
        trust_level = fields.dig("trust_level", "value").to_i

        # Only proceed if the user is in the chosen group
        if user.groups.pluck(:id).include?(group_id)
          begin
            # Attempt to lock trust level
            user.update!(manual_locked_trust_level: trust_level)
            Rails.logger.info(
              "DiscourseLockTL: Successfully locked TL#{trust_level} for user ##{user.id} " \
              "(#{user.username}) in group ##{group_id}"
            )
          rescue StandardError => e
            # Log error details without aborting the automation
            Rails.logger.error(
              "DiscourseLockTL: Error locking TL#{trust_level} for user ##{user.id} " \
              "(#{user.username}) in group ##{group_id}: #{e.class} – #{e.message}"
            )
            Rails.logger.error(e.backtrace.take(10).join("\n"))
          end
        end
      end
    end

  end
end
