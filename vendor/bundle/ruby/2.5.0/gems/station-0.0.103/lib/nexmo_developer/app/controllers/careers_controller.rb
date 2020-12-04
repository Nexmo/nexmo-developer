class CareersController < ApplicationController
  def index
    @careers_by_department = Greenhouse
                             .careers
                             .each_with_object(Hash.new { |h, k| h[k] = [] }) do |career, hash|
                               career.department_codes.each { |code| hash[code] << career }
                             end
  end
end
