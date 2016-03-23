function [ b2 ] = Ridge( X, y, tau, diff, lambda, b0 )
%(e) Ridge Regression Implementation
b1 = b0-5;
b2 = b0;
count = 0;
while (norm(b2-b1) > diff)
    b1 = b2;
    v = tau*X'*(y-X*b1);
    z = b1 + v;
    b2 = z/(1+lambda*tau);
    norm(b2-b1);
end
end
