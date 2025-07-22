import matplotlib.pyplot as plt

# Simulated CPU usage over time (in %)
cpu_usage = [10, 30, 60, 85, 70, 50, 20, 35, 90, 55, 15, 45]

# Frequency and Voltage levels for DVFS states
freq_levels = [0.5, 1.0, 1.5]  # in GHz
volt_levels = [0.9, 1.1, 1.3]  # in Volts

# Lists to store results
selected_freq = []
selected_volt = []
power_consumption = []
fsm_states = []

# FSM-based DVFS Controller
for usage in cpu_usage:
    if usage < 30:
        freq = freq_levels[0]
        volt = volt_levels[0]
        state = 'Low Load'
    elif usage < 70:
        freq = freq_levels[1]
        volt = volt_levels[1]
        state = 'Medium Load'
    else:
        freq = freq_levels[2]
        volt = volt_levels[2]
        state = 'High Load'

    power = volt ** 2 * freq  # P = V^2 * f
    selected_freq.append(freq)
    selected_volt.append(volt)
    power_consumption.append(power)
    fsm_states.append(state)

# Plotting the simulation results
time = list(range(len(cpu_usage)))

plt.figure(figsize=(12, 8))

# Plot 1: CPU Usage
plt.subplot(3, 1, 1)
plt.plot(time, cpu_usage, marker='o', color='blue', label='CPU Usage (%)')
plt.title('DVFS Controller Simulation')
plt.ylabel('CPU Usage (%)')
plt.grid(True)
plt.legend()

# Plot 2: Frequency & Voltage
plt.subplot(3, 1, 2)
plt.plot(time, selected_freq, marker='s', color='green', label='Frequency (GHz)')
plt.plot(time, selected_volt, marker='^', color='orange', label='Voltage (V)')
plt.ylabel('Freq / Volt')
plt.grid(True)
plt.legend()

# Plot 3: Power Consumption
plt.subplot(3, 1, 3)
plt.plot(time, power_consumption, marker='x', color='red', label='Power (W)')
plt.xlabel('Time Step')
plt.ylabel('Power Consumption (W)')
plt.grid(True)
plt.legend()

plt.tight_layout()
plt.show()
