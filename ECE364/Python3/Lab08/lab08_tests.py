import os
import sys
import uuid
from vtools import *
from verilog2vhdl import convertLine, convertFile

import unittest

def loadTextFiles(path1, path2):

    with open(path1, 'r') as firstFile:
        first = firstFile.read()

    with open(path2, 'r') as secondFile:
        second = secondFile.read()

    return first, second

class Lab08TestSuite(unittest.TestCase) :

    def test_checkPythonVersion(self):

        currentVersion = sys.version_info

        self.assertGreaterEqual(currentVersion, (3, 4))

    def test_isValidName(self):

        with self.subTest(key="U1"):
            self.assertTrue(isValidName("U1"))

        with self.subTest(key="_U2_"):
            self.assertTrue(isValidName("_U2_"))

        with self.subTest(key="1Superior2"):
            self.assertTrue(isValidName("1Superior2"))

        with self.subTest(key="%U3"):
            self.assertFalse(isValidName("%U3"))

        with self.subTest(key="*99_"):
            self.assertFalse(isValidName("*99_"))

        with self.subTest(key="What?"):
            self.assertFalse(isValidName("What?"))

    def test_parsePinAssignment(self):

        with self.subTest(key=".D(Q)"):
            assignment = ".D(Q)"
            expectedValue = "D", "Q"
            actualValue = parsePinAssignment(assignment)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key=".foo(_88_)"):
            assignment = ".foo(_88_)"
            expectedValue = "foo", "_88_"
            actualValue = parsePinAssignment(assignment)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key=".B2(n32)"):
            assignment = ".B2(n32)"
            expectedValue = "B2", "n32"
            actualValue = parsePinAssignment(assignment)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="AA(Here)"):
            assignment = "AA(Here)"

            self.assertRaises(ValueError, parsePinAssignment, assignment)

        with self.subTest(key=".$99(bin12)"):
            assignment = ".$99(bin12)"

            self.assertRaises(ValueError, parsePinAssignment, assignment)

        with self.subTest(key=".Linux(what?)"):
            assignment = ".Linux(what?)"

            self.assertRaises(ValueError, parsePinAssignment, assignment)

        with self.subTest(key=".ZZ3(p21"):
            assignment = ".ZZ3(p21"

            self.assertRaises(ValueError, parsePinAssignment, assignment)

        with self.subTest(key=".StarWars((VII))"):
            assignment = ".StarWars((VII))"

            self.assertRaises(ValueError, parsePinAssignment, assignment)

    def test_parseNetLine(self):

        with self.subTest(key="Valid 1"):
            line = "DFFSR Q_int1_reg ( .D(serial_in), .CLK(clk), .R(1), .S(n5), .Q(Q_int1) )"

            assignmentList = ("D", "serial_in"), ("CLK", "clk"), ("R", "1"), ("S", "n5"), ("Q", "Q_int1")
            expectedValue = "DFFSR", "Q_int1_reg", assignmentList
            actualValue = parseNetLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Valid 2"):
            line = "  OAI22X1     U11  (.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25))"

            assignmentList = ("A", "n32"), ("B", "n5"), ("C", "n3"), ("D", "n6"), ("Y", "n25")
            expectedValue = "OAI22X1", "U11", assignmentList
            actualValue = parseNetLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Missing Instance"):
            line = "BAD(.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25))"

            self.assertRaises(ValueError, parseNetLine, line)

        with self.subTest(key="Missing Component"):
            line = ".A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)"

            self.assertRaises(ValueError, parseNetLine, line)

        with self.subTest(key="Extra Parentheses"):
            line = "First U22 ((.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            self.assertRaises(ValueError, parseNetLine, line)

        with self.subTest(key="Invalid Names"):
            line = "First $U22 ((.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            self.assertRaises(ValueError, parseNetLine, line)

        with self.subTest(key="Extra Closing Parenthesis"):
            line = "First U22 (.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            self.assertRaises(ValueError, parseNetLine, line)

        with self.subTest(key="Bad Assignment"):
            line = "First U22 (.A(n32),.B(n?),.C(n3),.D(n6),.Y(n25))"

            self.assertRaises(ValueError, parseNetLine, line)

    def test_convertLine(self):

        with self.subTest(key="Valid 1"):
            line = "DFFSR Q_int1_reg ( .D(serial_in), .CLK(clk), .R(1), .S(n5), .Q(Q_int1) )"

            expectedValue = "Q_int1_reg: DFFSR PORT MAP(D=>serial_in, CLK=>clk, R=>1, S=>n5, Q=>Q_int1);"
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Valid 2"):
            line = "  OAI22X1     U11  (.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25))"

            expectedValue = "U11: OAI22X1 PORT MAP(A=>n32, B=>n5, C=>n3, D=>n6, Y=>n25);"
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Missing Instance"):
            line = "BAD(.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25))"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Missing Component"):
            line = ".A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Extra Parentheses"):
            line = "First U22 ((.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Invalid Names"):
            line = "First $U22 ((.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Extra Closing Parenthesis"):
            line = "First U22 (.A(n32),.B(n5),.C(n3),.D(n6),.Y(n25)))"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

        with self.subTest(key="Bad Assignment"):
            line = "First U22 (.A(n32),.B(n?),.C(n3),.D(n6),.Y(n25))"

            expectedValue = "Error: Bad Line."
            actualValue = convertLine(line)

            self.assertEqual(expectedValue, actualValue)

    def test_convertFile(self):

        sourceFileName = "verilog_test.v"
        expectedFileName = "vhdl_test.vhdl"
        actualFileName = str(uuid.uuid4()) + '.txt'

        convertFile(sourceFileName, actualFileName)
        actualValue, expectedValue = loadTextFiles(actualFileName, expectedFileName)
        os.remove(actualFileName)

        self.assertEqual(actualValue, expectedValue)

if __name__ == '__main__':
    unittest.main()
