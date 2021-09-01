// eslint-disable-next-line import/prefer-default-export
export function uniqueId(): string {
    return `_${Math.random().toString(36).substr(2, 9)}`;
}
