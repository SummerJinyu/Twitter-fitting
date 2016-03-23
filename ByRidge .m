diff = 0.00001;
tau = 1/10000; 
b0 = rand(1,12)';


data = load('dataset.csv');
A = data(:,1:12);
%A = [A';B']';
b = data(:,13);
x = linsolve (A,b); 
%Leave 126 cases
A = A(1:126,:);
%Divide into folders
dataSize = 126;
folderSize = 14;
folderNumber = 9;


%timeseries_error_rate = zeros([1 (folderNumber-1)]);
lambda = [1/8, 2/8, 3/8, 4/8, 5/8, 6/8, 7/8, 1, 2, 4, 8]
error_rate = zeros([length(folderNumber-1) (length(lambda))]);
for i = 1:(folderNumber-1)
    startIndex = 1;
    endIndex = folderSize*(i-1)+folderSize;
    trainIndex = false(1,(i+1)*folderSize);
    trainIndex(startIndex:endIndex) = true;
    train_A = A(trainIndex,:);
    train_b = b(trainIndex,:);
    test_A = A(~trainIndex,:);
    test_b = b(~trainIndex,:);
    
    for j = 1:length(lambda)
        beta_hat = ridge( train_A,train_b,tau,diff,lambda(j),b0);  
        result = int8(test_A*beta_hat>0.5);
        error_rate(i,j) = sum(test_b ~= result)/folderSize;
    end
end

error_rate

%mean(timeseries_error_rate)