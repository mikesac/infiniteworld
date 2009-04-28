package org.infinite.engines.map;

public class InaccessibleAreaException extends Exception {

	public InaccessibleAreaException(int status) {
		super(""+status);
	}

	private static final long serialVersionUID = 4701608965195778407L;

}
