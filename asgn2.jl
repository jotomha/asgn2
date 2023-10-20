# Part 1: See PDF

# Part 2      
using Random, GLM, DataFrames, CSV, Statistics

function regress_orthogonalize(Y, x)
    N, p = size(x)
    z = copy(x)
    γ_vec = zeros(p)
    
    for j in 1:p
        for k in 1:(j-1)
            γ = (z[:,j]' * z[:,k]) / (z[:,k]' * z[:,k])
            z[:,j] .-= γ .* z[:,k]
        end
    end

    for j in 1:p
        γ_vec[j] = (z[:,j]' * Y) / (z[:,j]' * z[:,j]) 
    end

    γ_last = (z[:,p]' * Y) / (z[:,p]' * z[:,p])
	return (z, γ_vec)
    #return γ_last[1] 
end

# Question 1
mtcars = DataFrame(CSV.File("mtcars.csv"))  # Convert csv data into dataframe
ols_est = lm(@formula(mpg ~ wt + hp), mtcars)  # mpg as output, wt + hp as input.
coefficients = coeftable(ols_est)  # Included in GLM package
@show coefficients
println("hp coefficient: ", coefficients.cols[1][3])
# Interpretation: For every increase in 1 horsepower, there is a 0.03 decrease in the mpg efficiency. 


# Question 2
y = vec(mtcars.mpg) # Directly accessing a column returns in array format, i just opted to convert to vector
x = [ones(32) vec(mtcars.wt) vec(mtcars.hp)]
z_vecs, coeff_vecs = regress_orthogonalize(y, x)
@show coeff_vecs
print("Regression: ", coeff_vecs[3])


# Question 3: 
@show coeff_vecs[1]
# Interpretation: the coefficient for the one's vector in the least squares Regression


# Question 4
@show z_vecs[:, 2]
@show mean(z_vecs[:, 2])
#Interpretation: the normalized weights vector


# Question 5
@show z_vecs[:, 1]' * z_vecs[:, 3]
#Interpretation: these are orthogonal


# Question 6
@show z_vecs[:, 2]' *z_vecs[:, 3]
#Interpretation: these are orthogonal


# Question 7
@show β_k = (z_vecs[:, 3]' * y) / (z_vecs[:, 3]' * z_vecs[:, 3])
#This is how the coefficient for the horsepower vector in the regression is calculated
