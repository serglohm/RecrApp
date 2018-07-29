class SetRightPhones < ActiveRecord::Migration[5.1]
  def change
    Candidate.where.not(phone: nil).each do |candidate|
      phone = candidate.phone.gsub(/\D/, '')
      candidate.update_attributes!(phone: phone)
    end
  end
end
