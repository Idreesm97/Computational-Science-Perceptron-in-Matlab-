% Step 1, this process is just writing the code and getting the logic
% working 
k = 1;
x = [];
x(k) = 0;
U = 0;
time = 0;
h = 0.1;
sampleInterval = 0.1;
%Adding random numbers variables
it = 0;
S = 0.01;
M = 0;
Xn = [];

%Create txt file for noisy numbers
fileID2 = fopen('step2.txt','W');
format2 = '%1.2f %1.3f %1.3f %1.0f\n';

%Create txt file for non - noisy numbers
fileID = fopen('step1.txt', 'w');
format = '%1.2f %1.3f %1.0f\n';

while time <= 15
    if (0 < time) && (time <= 5)
        U = 2;
    elseif (5 < time) && (time <= 10)
        U = 1;
    elseif (10 < time) && (time <= 15)
        U = 3;
    end
    if time == 0
        fprintf(fileID, format, time, x(k), U);
    end
    %x(k) = U - exp(-2 * time);
    x(k+1) = x(k)+h*(-2*x(k)+2*U);
    k = k + 1;
    
    %Adding the numbers to the step1.txt
    fprintf(fileID, format, time, x(k), U);
    
    %Adding Random Numbers(step 2)
    if (it == 0)
        z1 = 0+rand*(2*pi-0);
        temp1 = 0+rand(1-0);
        temp = sqrt(-2*log(temp1));
        b = S * temp;
        z2 = b * sin(z1)+M;
        z3 = b * cos(z1)+M;
        Xn = [Xn x(k) + z2];
        %Write noisy numbers to file
        fprintf(fileID2, format2, time, x(k), Xn(k-1), U);
        it = 1;
    else
        it = 0;
        Xn = [Xn x(k) + z3];
        %Write to step 2 file
        fprintf(fileID2, format2, time, x(k), Xn(k-1), U);
    end
    time = time + h;
end
hold on;
plot(Xn,'DisplayName','Xn');
plot(x,'DisplayName', 'X')
hold off;
legend;
xlabel("Time");
ylabel("Values")
fclose(fileID);
fclose(fileID2);


    
