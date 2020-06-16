function [s, f, t] = random_signal(Fs, L)
    T = 1/Fs;
    t = (0:L-1)*T;
    f = randi(200) + 30
    t1 = randi(L-500)
    t2 = randi(L-t1-300) + t1 + 299
    
    x = rand() * sin(2*pi*f*t);
    s = zeros(1, L)
    
    s(t1:t2) = x(1:t2-t1+1)
    t = [t1/Fs t2/Fs]
end
