function [ b ] = ridge2( X, y, lambda )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
I = eye(17);
b = inv(X'*X + lambda*I)*X'*y;
end

