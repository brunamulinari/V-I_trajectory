function[A, B, C, D, A0, C0] = fourier_2D(Wmed, n_harmonics)
%
% IN:
% Wmed - Matrix with voltage and current values: 
%			Wmed = [Vmed Imed]
% 		 where Vmed and Imed have n samples. Where n equals the 
%        number of samples in one grid cycle. 
% n_harmonics - Number of harmonics 
%
% OUT:
% A, B, C, D, A0, C0 -  Two-Dimensional Fourier Series Descriptors
%
% This code is explained and detailed in the paper 
% “Feature Extraction of V-I Trajectory using 2-D Fourier Series 
% for Electrical Load Classification". Submitted to Electric Power 
% Systems Research (ELSEVIER), 2021 (under review)
%
% (C) Bruna M. Mulinari, Federal University of Technology - Paraná. 
%
% Version: 1.0, 10 Dezember 2020
% 


% Number of samples
K = length(Wmed);                                

deltax = Wmed(2:end,1)-Wmed(1:end-1,1);
deltay = Wmed(2:end,2)-Wmed(1:end-1,2);
deltat = sqrt(deltax.^2+deltay.^2);
T = sum(deltat);


t = zeros(1, K-1);
for p=1:K-1
    
    t(p)=0;
    
    for i=1:p
        
        % Accumulated arc length 
        t(p)=t(p)+deltat(i);
        
    end
    
end

clear i, clear p;

A = zeros(1,n_harmonics);
B = zeros(1,n_harmonics);
C = zeros(1,n_harmonics);
D = zeros(1,n_harmonics);
for N = 1:n_harmonics
    
    for n = 1:N
        
        An = (deltax(1)/deltat(1))*(cos(2*n*pi*t(1)/T)-1);
        Bn = (deltax(1)/deltat(1))*sin(2*n*pi*t(1)/T);
        Cn = (deltay(1)/deltat(1))*(cos(2*n*pi*t(1)/T)-1);
        Dn = (deltay(1)/deltat(1))*sin(2*n*pi*t(1)/T);
        
        for p = 2:K-1
            
            incx = deltax(p)/deltat(p);
            incy = deltay(p)/deltat(p);
            
            if(isnan(incx))
                incx = 0;
            end
            if(isnan(incy))
                incy = 0;
            end
            
            An=An+(incx)*( cos(2*n*pi*t(p)/T)-cos(2*n*pi*t(p-1)/T) );
            Bn=Bn+(incx)*( sin(2*n*pi*t(p)/T)-sin(2*n*pi*t(p-1)/T) );
            Cn=Cn+(incy)*( cos(2*n*pi*t(p)/T)-cos(2*n*pi*t(p-1)/T) );
            Dn=Dn+(incy)*( sin(2*n*pi*t(p)/T)-sin(2*n*pi*t(p-1)/T) );
            
        end
        
        % A-descriptors
        A(n)=( T/(2*(n^2)*(pi^2)) )*An;
        % B-descriptors
        B(n)=( T/(2*(n^2)*(pi^2)) )*Bn;
        % C-descriptors
        C(n)=( T/(2*(n^2)*(pi^2)) )*Cn;
        % D-descriptors
        D(n)=( T/(2*(n^2)*(pi^2)) )*Dn;
        
    end
end

% Scalar descriptors 
A0 = mean(Wmed(:,1));
C0 = mean(Wmed(:,2));

end