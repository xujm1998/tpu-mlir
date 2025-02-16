import numpy as np
import unittest
from tpulang_custom_test_base import TestTPULangCustom
import transform.TpuLang as tpul
import my_tpulang_layer

class TestSwapChannel(TestTPULangCustom):
    def _test(self, dtype):
        shape = [4, 3, 36, 36]
        self.data_in = np.random.random(shape).astype(dtype)
        x = tpul.Tensor(name="in", dtype=dtype, shape=shape, data=self.data_in)
        y = my_tpulang_layer.swapChannel.tpulang(inputs=[x], dtype=dtype)[0]
        self.compile('SwapChannel', [x], [y], dtype)
    def test_fp32(self):
        self._test('float32')
    def test_fp16(self):
        self._test('float16')

if __name__ == '__main__':
    unittest.main()
