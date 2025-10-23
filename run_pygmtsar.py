# run_test.py
import pygmtsar

print("✅ PyGMTSAR import test passed.")
print("Installed version:", pygmtsar.__version__)
print("Available modules:", list(pygmtsar.__dict__.keys())[:10], "...")

