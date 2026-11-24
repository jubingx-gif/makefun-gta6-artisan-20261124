import { copyFileSync, mkdirSync, existsSync } from 'fs';
import { join } from 'path';

/**
 * make.fun GTA 6 Bounty Submission Script
 * Task: Build the most complete open-world crime game you can
 * Description: Copies index.html to the output for browser-based play.
 */

const SOURCE_FILE = join(process.cwd(), 'index.html');
const OUTPUT_DIR = '/output';
const OUTPUT_FILE = join(OUTPUT_DIR, 'index.html');

try {
  if (!existsSync(OUTPUT_DIR)) {
    mkdirSync(OUTPUT_DIR, { recursive: true });
  }
  copyFileSync(SOURCE_FILE, OUTPUT_FILE);
  console.log(`Successfully deployed GTA 6 prototype to ${OUTPUT_FILE}`);
} catch (error) {
  console.error('Deployment failed:', error);
  process.exit(1);
}
