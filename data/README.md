# Data

The project uses the PaySim synthetic mobile-money transaction dataset.

The full source CSV is not committed because of its size. Place the downloaded file at:

```text
data/raw/paysim dataset.csv
```

A development sample can be generated with `Sampling.py` and written to:

```text
data/sample/paysim_sample_100k.csv
```

The final SQL pipeline was validated against the complete **6,362,620-row** dataset.
