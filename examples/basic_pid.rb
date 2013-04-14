pid = PID.new :kp => 1.0, :ki => 2.0, :kd => 1.0, :maximum => 100
pid.setpoint = 100.0 # Target temperature, in Degrees F

# Use whatever code you need to get temp. For this, take random temp
def get_current_temperature
  temp = rand(100).to_f
  puts "Temperature reading of #{temp}"

  temp
end

# Set your heating/cooling output based on output response. You could
# Feed this to a PWM pin to module by power_level as a percentage.
# (75.0 power_level means 75% power)
def set_power_level power_level
  puts "Set power to #{power_level}"
end


# Control temperature for an hour
duration = 3600
end_time = Time.now + duration

while Time.now < end_time do
  input = get_current_temperature
  power_level = pid.control input

  set_power_level power_level
end
