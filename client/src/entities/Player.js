import {
  Vector3
} from 'three';

const DEFAULT_POSITION = new Vector3(0, 0, 0);
const DEFAULT_ROTATION = new Vector3(0, 0, 0);

export default class Player {
  constructor(position = DEFAULT_POSITION, rotation = DEFAULT_ROTATION) {
    console.log('Creating Player instance');

    this.playerPosition = position;
    this.playerRotation = rotation;
  }

  get position() {
    return this.playerPosition;
  }

  get rotation() {
    return this.playerRotation;
  }
}
