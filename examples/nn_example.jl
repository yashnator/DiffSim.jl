using DiffSim
using Plots

function gravitational_force(pos, vel, t, params)
    r = sqrt(sum(pos.^2))
    if r < 1e-12
        return [0.0, 0.0]
    end
    
    r_hat = pos / r
    F_magnitude = params[1] / r^2
    
    return -F_magnitude * r_hat
end

target_radius = 5.0
orbital_period = 2π
target_speed = 2π * target_radius / orbital_period
theoretical_GM = target_speed^2 * target_radius

initial_pos = [target_radius, 0.0]
initial_vel = [0.0, target_speed]

quarter_period = orbital_period / 4
target_pos = [0.0, target_radius]

optimal_GM, error = solve_parameters_with_velocity(
    gravitational_force, [10.0],
    initial_position = initial_pos,
    initial_velocity = initial_vel,
    target_position = target_pos,
    total_time = quarter_period
)
    
println("Theoretical G * M value: $(round(theoretical_GM, digits=2))")
println("Calculated GM: $(round(optimal_GM[1], digits=2))")
println("Error in diff sim: $(round(error, digits=6))")
println("Difference from theory: $(round(abs(optimal_GM[1] - theoretical_GM), digits=2))")
