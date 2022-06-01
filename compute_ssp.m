function c=compute_ssp(T,S,z,method)

switch method
    case 'mackenzie' % sound speed based on Mackenzie Equation
        c = 1448.96 + 4.591*T - 5.304e-2*T.^2 + 2.374e-4*T.^3 + 1.340*(S-35)...
            + 1.630e-2*z + 1.675e-7*z.^2 - 1.025e-2*T.*(S-35) - 7.139e-13*T.*z.^3;
end

