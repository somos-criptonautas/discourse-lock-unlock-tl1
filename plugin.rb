# frozen_string_literal: true

# name: discourse-lock-unlock-tl
# about: Locks or unlocks user trust levels via Discourse Automation.
# version: 0.4
# authors: satonotdead
# url: https://github.com/somos-criptonautas/discourse-lock-unlock-tl

after_initialize do
  if defined?(DiscourseAutomation)
    # Script to lock a user's trust level when added to a group
    DiscourseAutomation::Scriptable.add("lock_user_tl_on_group_add") do
      version 1
      triggerables %i[user_added_to_group]

      field :target_group, component: :group, required: true
      field :trust_level, component: :trust_level, required: true

      script do |context, fields, automation|
        user = context["user"]
        group_id = fields.dig("target_group", "value")
        trust_level = fields.dig("trust_level", "value")

        if user.group_ids.include?(group_id)
          begin
            user.update!(manual_locked_trust_level: trust_level)
            Rails.logger.info(
              "DiscourseLockUnlockTL: Locked TL#{trust_level} for user ##{user.id} in group ##{group_id}.",
            )
          rescue StandardError => e
            Rails.logger.error(
              "DiscourseLockUnlockTL: Error locking TL for user ##{user.id}: #{e.message}",
            )
          end
        end
      end
    end

    # Script to unlock a user's trust level
    DiscourseAutomation::Scriptable.add("unlock_user_trust_level") do
      version 1
      triggerables %i[user_removed_from_group]

      field :target_group, component: :group, required: true

      script do |context, fields, automation|
        user = context["user"]
        group_id = fields.dig("target_group", "value")

        # Unlock only if the user is no longer in the target group
        unless user.group_ids.include?(group_id)
          begin
            user.update!(manual_locked_trust_level: nil)
            Rails.logger.info(
              "DiscourseLockUnlockTL: Unlocked TL for user ##{user.id} from group ##{group_id}.",
            )
          rescue StandardError => e
            Rails.logger.error(
              "DiscourseLockUnlockTL: Error unlocking TL for user ##{user.id}: #{e.message}",
            )
          end
        end
      end
    end
  end
end
