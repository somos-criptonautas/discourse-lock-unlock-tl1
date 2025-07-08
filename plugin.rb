# plugin.rb
# name: discourse-lock-tl1
# about: Locks new group members to Trust Level 1 via Automation, with error logging
# version: 0.2
# authors: satonotdead

after_initialize do
  # Proceed only if the Automation plugin is loaded
  if defined?(DiscourseAutomation)

    DiscourseAutomation::Scriptable.add("lock_group_tl1") do
      version 1

      # Admin field to select the target group
      field :target_group, component: :group, required: true

      # Run this script when a user is added to any group
      triggerables %i[user_added_to_group]

      script do |context, fields, automation|
        user     = context["user"]
        group_id = fields.dig("target_group", "value").to_i

        # Only proceed if the user is in the chosen group
        if user.groups.pluck(:id).include?(group_id)
          begin
            # Attempt to lock trust level at 1
            user.update!(manual_locked_trust_level: 1)
            Rails.logger.info(
              "DiscourseLockTL1: Successfully locked TL1 for user ##{user.id} "\
              "(#{user.username}) in group ##{group_id}"
            )
          rescue StandardError => e
            # Log error details without aborting the automation
            Rails.logger.error(
              "DiscourseLockTL1: Error locking TL1 for user ##{user.id} "\
              "(#{user.username}) in group ##{group_id}: #{e.class} – #{e.message}"
            )
            Rails.logger.error(
              e.backtrace.take(10).join("\n")
            )
          end
        end
      end
    end

  end
end
