#!/usr/bin/env python3
import argparse
import json
import math
from pathlib import Path

import matplotlib.pyplot as plt

KEYS = ["sonne", "sicht", "quartier", "dienstl", "freiz", "oeverk", "strassen", "laerm"]
LABELS = [
    "Besonnung",
    "Aussicht",
    "Image des Quartiers",
    "Dienstleistungen",
    "Freizeit/Erholung",
    "Öffentlicher Verkehr",
    "Strassenanbindung",
    "Lärmbelastung",
]


def main():
    parser = argparse.ArgumentParser(description="Erzeugt den FPRE-Mikrolage-Spider als PNG.")
    parser.add_argument("--nutzung", required=True)
    parser.add_argument("--adresse", required=True)
    parser.add_argument("--werte", required=True, help="JSON-Objekt mit den acht Subratings")
    parser.add_argument(
        "--gesamtrating",
        required=True,
        type=float,
        help="Mikro-Lagerating der Nutzung, wird im Titel ausgewiesen",
    )
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    if args.gesamtrating < 1.0 or args.gesamtrating > 5.0:
        raise ValueError("Das Gesamtrating muss zwischen 1.0 und 5.0 liegen.")

    values_obj = json.loads(args.werte)
    missing = [key for key in KEYS if key not in values_obj]
    if missing:
        raise ValueError("Fehlende Subratings: " + ", ".join(missing))

    values = [float(values_obj[key]) for key in KEYS]
    if any(value < 1.0 or value > 5.0 for value in values):
        raise ValueError("Alle Subratings müssen zwischen 1.0 und 5.0 liegen.")

    angles = [2 * math.pi * i / len(KEYS) for i in range(len(KEYS))]
    closed_angles = angles + [angles[0]]
    closed_values = values + [values[0]]

    fig = plt.figure(figsize=(9, 9))
    ax = fig.add_subplot(111, polar=True)
    ax.plot(closed_angles, closed_values, linewidth=2)
    ax.set_ylim(1, 5)
    ax.set_yticks([1, 2, 3, 4, 5])
    ax.set_xticks(angles)
    ax.set_xticklabels([f"{label}\n{value:.1f}" for label, value in zip(LABELS, values)])
    ax.set_title(
        f"FPRE-Mikrolage {args.nutzung} {args.gesamtrating:.1f}\n{args.adresse}",
        pad=28,
    )
    ax.grid(True)

    output = Path(args.output)
    output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(output, dpi=180, bbox_inches="tight")
    plt.close(fig)


if __name__ == "__main__":
    main()
