namespace :scheduler do
  desc 'Send taking medication reminders'
  task send_take_medication_reminders: :environment do
    MedicationReminders.new.send_take_medication_reminder_emails
  end

  desc 'Send refill reminders'
  task send_refill_reminders: :environment do
    MedicationReminders.new.send_refill_reminder_emails
  end

  desc 'Send strategy library reminders'
  task strategy_email_reminder: :environment do
    StrategyReminders.new.send_strategy_reminder_emails
  end

  desc 'Selfcare reminders'
  task selfcare_reminder: :environment do
    StrategyReminders.new.send_weekly_reminder_emails
  end

  desc 'Send meeting reminders'
  task send_meeting_reminders: :environment do
    MeetingReminders.new.send_meeting_reminder_emails
  end
end
