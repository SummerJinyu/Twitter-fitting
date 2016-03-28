clear 
%1.score
data = load('dataset.csv');
A1 = data(:,1:12);
%A = [A';B']';

%2.label
data2 = load('stock.csv'); 
A2 = data2(:, 2:6); 

X = [A1 A2]; 
y = data(:,13); 
dim_A = size(X);
feature_number = dim_A(2);



folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
X = X(1:dataSize,:); X = [X ones([dataSize 1])]; %intercept
y = y(1:dataSize,:); 

%change y into -1 and 1 
for i = 1:dataSize 
    if (y(i) == 0) 
        y(i) = -1;
    end
end


lambda = [1/8, 1/4, 1/2, 3/4, 1, 2, 4];
error_rate_SVM = zeros([length(folderNumber-1) (length(lambda))]);
for i = 1:(folderNumber-1)
    startIndex = 1;
    endIndex = folderSize*(i-1)+folderSize;
    trainIndex = false(1,(i+1)*folderSize);
    trainIndex(startIndex:endIndex) = true;
    train_A = X(trainIndex,:);
    train_b = y(trainIndex,:);
    test_A = X(~trainIndex,:);
    test_b = y(~trainIndex,:);
    size(train_A)
    for j = 1:length(lambda)
        %fitting
        train_dataSize = size(train_b);
        beta_hat = SVM1( train_A, train_b, lambda(j), feature_number, train_dataSize(1));
        result = int8(test_A*beta_hat>0);
        error_rate_SVM(i,j) = sum(test_b ~= result)/folderSize;
    end
end

error_rate_SVM
