package Common is    -- untested...

  type op_t is (
    op_add, op_sub,
    op_sll, op_slt,
    op_sltu, op_xor,
    op_srl, op_sra,
    op_or, op_and
    );

  subtype inst_t is std_logic_vector(31 downto 0);
  subtype reg_entry_t is std_logic_vector(31 downto 0);


end Common;

package body Common is
   -- subprogram bodies here
end Common;
