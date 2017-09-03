# frozen_string_literal: true

module CalendarHelper
  def new_cal_refill_reminder_needed?(medication)
    if medication.add_to_google_cal &&
       medication.refill &&
       (medication.add_to_google_cal_changed? || medication.refill_changed?)
      true
    else
      false
    end
  end

  def new_cal_refill_reminder_unneeded?(medication)
    if medication.add_to_google_cal &&
       medication.refill &&
       (medication.add_to_google_cal_changed? || medication.refill_changed?)
      false
    else
      true
    end
  end
end
