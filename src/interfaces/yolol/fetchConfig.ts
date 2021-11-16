export interface FetchConfigScript {
    name?: string | null;
    uri: string;
}

export interface FetchConfig {
    docs: string;
    scripts: FetchConfigScript[];
}

export interface FetchConfigRequest {
    fetchConfigUri: string;
}

export interface FetchConfigValidationResult {
    fetchConfig: FetchConfig;
    successes: Record<string, string[]>;
    errors: Record<string, string[]>;
}
