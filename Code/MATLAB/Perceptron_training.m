filename = 'step2.txt'; %File to open
delimiterIn = ' ';
headerlinesIn = 0;
A = importdata(filename,delimiterIn,headerlinesIn);
counter = 0;
tempInputs = (A(:, 3));
%tempZero = 0;
%norm = [tempZero; tempInputs];
inputs = rescale(tempInputs); %norm

Output = 0; %output
Target = 0; %target
J = 1; %cost function. when training is finished should be 0, and j/w = 0 (see slide 13) J = 0.5(T - O)^2
Error = 0;

learningRate = 0.0001;

R = [-0.5 0.5];
weights = rand(3,1)*range(R)+min(R);
%activated = false;
z = 1;
for r = 0:100000
    netsumArray = [];
    for n = 1 : (length(inputs) - 2)
        tInputs = [inputs(n) inputs(n+1) 1];
        %Simulate perceptron
        net_sum = 0;
        for m = 1 : 3
            net_sum = net_sum + tInputs(m) * weights(m);
        end
        Output = 1/(1 + (exp(1)^-net_sum));
        netsumArray = [netsumArray (net_sum)];

        %Perceptron training algorithm
        Target = inputs(n+2);
        Delta = Target - net_sum;
        for m = 1 : 3
            weights(m) = weights(m) + (learningRate * Delta * tInputs(m));
        end
        Error = Delta;
        J = 0.5*((Error)^2);
    end
end