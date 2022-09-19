#include <iostream>
#include <bitset>
#include <cmath>
#include <algorithm>
#include <fstream>

using namespace std;

class Calc
{
public:
    static const uint32_t A_SGN_8_BIT_MASK = 0b00001000;
    static const uint32_t A_MAG_8_BIT_MASK = 0b00000111;
    static const uint32_t B_SGN_8_BIT_MASK = 0b10000000;
    static const uint32_t B_MAG_8_BIT_MASK = 0b01110000;
    static const uint32_t R_MAG_8_BIT_MASK = 0b00000111;

    static const uint32_t A_SGN_16_BIT_MASK = 0b0000000010000000;
    static const uint32_t A_MAG_16_BIT_MASK = 0b0000000001111111;
    static const uint32_t B_SGN_16_BIT_MASK = 0b1000000000000000;
    static const uint32_t B_MAG_16_BIT_MASK = 0b0111111100000000;
    static const uint32_t R_MAG_16_BIT_MASK = 0b0000000001111111;

    int addr_size;
    int data_size;
    uint32_t depth;
    ofstream truth_table_out;
    Calc(int addr_size)
    {
        this->addr_size = addr_size;
        if (this->addr_size != 8 && this->addr_size != 16)
        {
            throw std::invalid_argument("Only supports 8 and 16 bit addresses");
        }
        this->data_size = (int)(addr_size / 2);
        this->depth = pow(2, addr_size);
        this->calculate();
    }

    uint32_t get_a_sgn(uint32_t val)
    {
        return (val & (this->addr_size == 8 ? A_SGN_8_BIT_MASK : A_SGN_16_BIT_MASK)) >> (this->data_size - 1);
    }

    uint32_t get_a_mag(uint32_t val)
    {
        return val & (this->addr_size == 8 ? A_MAG_8_BIT_MASK : A_MAG_16_BIT_MASK);
    }

    uint32_t get_b_sgn(uint32_t val)
    {
        return (val & (this->addr_size == 8 ? B_SGN_8_BIT_MASK : B_SGN_16_BIT_MASK)) >> ((data_size * 2) - 1);
    }

    uint32_t get_b_mag(uint32_t val)
    {
        return (val & (this->addr_size == 8 ? B_MAG_8_BIT_MASK : B_MAG_16_BIT_MASK)) >> (data_size);
    }

    uint32_t get_r_mag(uint32_t val)
    {
        return val & (this->addr_size == 8 ? R_MAG_8_BIT_MASK : R_MAG_16_BIT_MASK);
    }

    void calculate()
    {
        string file_name = "rom_" + to_string(this->addr_size) + "_sign_mag.txt";
        truth_table_out.open(file_name);

        for (uint32_t i = 0; i < this->depth; i++)
        {
            uint32_t a_sgn = this->get_a_sgn(i);
            uint32_t a_mag = this->get_a_mag(i);
            uint32_t b_sgn = this->get_b_sgn(i);
            uint32_t b_mag = this->get_b_mag(i);

            uint32_t r_mag;
            uint32_t r_sgn;

            // If the two operands have the same sign, add the magnitude and keep the sign
            if (a_sgn == b_sgn)
            {
                r_mag = a_mag + b_mag;
                if (r_mag == 0)
                {
                    r_sgn = 0;
                }
                else
                {
                    r_sgn = a_sgn;
                }
            }
            else
            {
                // If the two operands have different signs, subtract the smaller magnitude from the larger one
                r_mag = this->get_r_mag((max(a_mag, b_mag) - min(a_mag, b_mag)));
                // And keep the larger one's sign
                if (a_mag > b_mag)
                {
                    r_sgn = a_sgn;
                }
                else if (b_mag > a_mag)
                {
                    r_sgn = b_sgn;
                }
                else
                {
                    r_sgn = 0;
                }
            }

            if (this->addr_size == 8)
            {
                truth_table_out << bitset<1>(r_sgn)
                                << bitset<3>(r_mag)
                                << endl;
            }
            else
            {
                truth_table_out << bitset<1>(r_sgn)
                                << bitset<7>(r_mag)
                                << endl;
            }
        }

        truth_table_out.close();
    }
};

int main()
{
    Calc calc_8(8);
    Calc calc_16(16);
    return 0;
}