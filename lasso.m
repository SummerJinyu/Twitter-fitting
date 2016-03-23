function [ b2 ] = lasso( X, y, tau, diff, lambda, b0)

%(a) iterative soft-thresholding for Lasso
b1 = b0-5;
b2 = b0;
count = 0;
while (norm(b2-b1) > diff)
    b1 = b2;
    v = tau*X'*(y-X*b1);
    z = b1 + v;
    for i = 1:length(b2)
        b2(i) = sign(z(i))*max(0, abs(z(i))-tau*lambda/2);
    end
    count = count + 1;
end
end

