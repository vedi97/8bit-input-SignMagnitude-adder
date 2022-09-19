import itertools

def create_sign_mag_truth_table(addr_size=8, verbose=True):
    ADDR_SIZE = addr_size
    FILE=f("rom1_{ADDR_SIZE}_bit_sign_mag.txt");

    MID = int(ADDR_SIZE/2)
    DATA_SIZE = MID
    VERBOSE = verbose

    # Generate 2^ADDR_SIZE truth table
    truth_table_in = [i for i in itertools.product([0,1], repeat=ADDR_SIZE)]

    # Convert int to string binary with at least n bits
    to_bin = lambda x, n: format(x, 'b').zfill(n)

    # Variable to hold output of truth table
    truth_table_out = open(FILE, 'w')

    # iterate the truth table
    for i, addr in enumerate(truth_table_in):

        a_sgn = addr[0]
        a_mag = ''.join(map(str,addr[1:MID]))
        b_sgn = addr[MID]
        b_mag = ''.join(map(str,addr[MID+1:ADDR_SIZE]))

        a_int = int(a_mag, 2)
        b_int = int(b_mag, 2)

        # If the two operands have the same sign, add the magnitude and keep the sign
        if (a_sgn == b_sgn):
            r_int = a_int + b_int
            # If the result magnitude is 0 just use +0 
            if r_int == 0:
                r_sgn = 0
            else:
                r_sgn = a_sgn
        else:
            # If the two operands have different signs, subtract the smaller magnitude from the larger one
            r_int = max(a_int, b_int) - min(a_int, b_int)
            # And keep the larger one's sign
            if a_int > b_int:
                r_sgn = a_sgn
            elif b_int > a_int:
                r_sgn = b_sgn
            else:
                r_sgn = 0

        r_bin = to_bin(r_int, DATA_SIZE-1)

        if VERBOSE:
            log_msg = f("{i+1}: {addr} = {a_sgn} {a_mag} + {b_sgn} {b_mag} = {r_sgn} {r_bin}");
            if len(r_bin) > (DATA_SIZE -1):
                log_msg += " overflow"
            print(log_msg)

        # Save result to the file
        if len(r_bin) > DATA_SIZE - 1:
            r_bin_str = str(r_bin)[1:DATA_SIZE]
        else:
            r_bin_str = str(r_bin)

        truth_table_out.write(f('{r_sgn}{r_bin_str}\n'))

    truth_table_out.close()
    
if __name__=="__main__":
    create_sign_mag_truth_table(8)
    create_sign_mag_truth_table(16)
