package com.google_ml_kit_sidelying_leg_raises.vision.classification;

import android.util.Log;
import com.google.common.base.Splitter;
import com.google.mlkit.vision.common.PointF3D;
import java.util.ArrayList;
import java.util.List;

/**
 * Reads Pose samples from a csv file.
 */
public class PoseSample {
  private static final String TAG = "PoseSample";
  private static final int NUM_LANDMARKS = 33;
  private static final int NUM_DIMS = 3;

  private final String name;
  private final String className;
  private final List<PointF3D> embedding;

  public PoseSample(String name, String className, List<PointF3D> landmarks) {
    this.name = name;
    this.className = className;
    this.embedding = PoseEmbedding.getPoseEmbedding(landmarks);
  }

  public String getName() {
    return name;
  }

  public String getClassName() {
    return className;
  }

  public List<PointF3D> getEmbedding() {
    return embedding;
  }

  public static PoseSample getPoseSample(String csvLine, String separator) {
    List<String> tokens = Splitter.onPattern(separator).splitToList(csvLine);
    // Format is expected to be Name,Class,X1,Y1,Z1,X2,Y2,Z2...
    // + 2 is for Name & Class.
    if (tokens.size() != (NUM_LANDMARKS * NUM_DIMS) + 2) {
      Log.e(TAG, "Invalid number of tokens for PoseSample");
      return null;
    }
    String name = tokens.get(0);
    String className = tokens.get(1);
    List<PointF3D> landmarks = new ArrayList<>();
    // Read from the third token, first 2 tokens are name and class.
    for (int i = 2; i < tokens.size(); i += NUM_DIMS) {
      try {
        landmarks.add(
            PointF3D.from(
                Float.parseFloat(tokens.get(i)),
                Float.parseFloat(tokens.get(i + 1)),
                Float.parseFloat(tokens.get(i + 2))));
      } catch (NullPointerException | NumberFormatException e) {
        Log.e(TAG, "Invalid value " + tokens.get(i) + " for landmark position.");
        return null;
      }
    }
    return new PoseSample(name, className, landmarks);
  }
}
