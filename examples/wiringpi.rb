# This example uses the mruby-WiringPi (https://github.com/akiray03/mruby-WiringPi) lib to
# read from a GPIO port for sensor data, and output the power level to a PWM GPIO port

pid = PID.new :kp => 1.0, :ki => 2.0, :kd => 1.0, :maximum => 100
pid.setpoint = 100.0 # Target temperature, in Degrees F

# Set GPIO pins
io = WiringPi::GPIO.new
sensor_pin = 7
heater_pin = 11
io.mode sensor_pin, WiringPi::INPUT
io.mode heater_pin, WiringPi::PWM_OUTPUT

# Control temperature for an hour
duration = 3600
end_time = Time.now + duration

while Time.now < end_time do
  input = io.read sensor_pin
  power_level = pid.control input
  io.pwmWrite heater_pin, power_level
end
