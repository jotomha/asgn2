# Part 1 --> Will need to be put into a PDF file, i just put it here so that we could both access it through the github rn

# 1: Record a video in which you prove the independence-dimension inequality.
# 
# Link: TODO INSERT HERE

# 2: Spaghetti Stick Orthogonal Projection
#
# TODO

# 3: 
#
# (i): ||a|| = 5 ; ||b|| = 3 ; ||c|| = 4
# (ii): aᵀb = 9
# (iii): b̂ = 9/5
# (iv): θ = arccos(9/15)
# (v): bᵀa/||b|| is the orthogonal projection of a onto b, whereas aᵀb/||a|| 
# is the orthogonal projection of b onto a.

# 4:
# 
# (a) Let m₁ ... mₖ be coefficients such that m₁c₁ + ... + mₖcₖ = 0. This can be 
# expanded as [m₁a₁ + ... + mₖaₖ; m₁b₁ + ... + mₖbₖ] = 0. Since a₁ ... aₖ is known
# to be linearly independent, m₁ = ... = mₖ = 0. Therefore, c₁ ... cₖ must be linearly independent.
# (b) Following the same logic as part (a), you cannot determine with certainty that c₁ ... cₖ are 
# linearly independent. If vectors b₁ ... bₖ are linearly independent, then so is c₁ ... cₖ.

# 5: 
# bᵀ(a - γb) = 0
# bᵀa - bᵀγb = 0
# bᵀa = γbᵀb
# γ||b||² = bᵀa
# γ = bᵀa / ||b||²


# Part 2      to calvin: if it says that package GLM is not installed, just activate the project by going into package mode and then activate .
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
    #return γ_last[1]  Extract the scalar from the 1x1 array
end

# Question 1
mtcars = DataFrame(CSV.File("mtcars.csv"))  # Convert csv data into dataframe
ols_est = lm(@formula(mpg ~ wt + hp), mtcars)  # mpg as output, wt + hp as input. Not sure if you've used R before, seems to be the same syntax, but I have never used it so new to me
coefficients = coeftable(ols_est)  # Included in GLM package
@show coefficients
println("hp coefficient: ", coefficients.cols[1][3])

# Interpretation: For every increase in 1 horsepower, there is a 0.03 decrease in the mpg efficiency.  !! I HAVE ABSOLUTELY NO IDEA WHAT IT MEANS. THIS IS A WILD GUESS FROM WHAT I KNOW ABOUT LINEAR REGRESSION.


# Question 2
y = vec(mtcars.mpg) # Directly accessing a column returns in array format, i just opted to convert to vector, which probably isn't necessary
x = [ones(32) vec(mtcars.wt) vec(mtcars.hp)]
z_vecs, coeff_vecs = regress_orthogonalize(y, x)
#@show z_vecs
@show coeff_vecs
print("Regression: ", coeff_vecs[3])  # returns almost the same number! is this correct?? Unclear


# Question 3: I do not know how to retrieve any of these values. Are we meant to print them within the orthogonal_regression function? 
# Or return the whole matrix z? 
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
