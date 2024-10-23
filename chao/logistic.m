function [x] = logistic(x0, r, n)
    % Logistic map
    % @param x0 initial value
    % @param r parameter
    % @param n number of iterations

    % @return x logistic map series
    x = zeros(1, n);
    x(1) = x0;
    for i = 2:n
        x(i) = r * x(i-1) * (1 - x(i-1));
    end
end
